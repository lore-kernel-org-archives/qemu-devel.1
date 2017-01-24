Received: from eggs.gnu.org ([2001:4830:134:3::10]:36958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cVzCA-0004vy-Ak
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cVzC9-000786-ID
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:23:26 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
	<20170122142959.GA12419@lemon.Home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff2fd02a-09ea-a28f-eb6e-e1858efff552@redhat.com>
Date: Tue, 24 Jan 2017 12:23:16 +0100
MIME-Version: 1.0
In-Reply-To: <20170122142959.GA12419@lemon.Home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] scsi-generic and BLKSECTGET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 22/01/2017 15:29, Fam Zheng wrote:
> On Fri, 01/20 17:25, Eric Farman wrote:
>> Changes:
>>  v2->v3:
>>   - Move byte/sector conversions to patch 2 [Fam Zheng]
>>   - Rename "max_sectors" when holding a byte value [Fam Zheng]
>>  v1->v2:
>>   - Patch 3, make hdev_get_max_transfer_length return bytes [Fam Zheng]
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>

Looks good, who's merging this? :)

Paolo
