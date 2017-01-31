Received: from eggs.gnu.org ([2001:4830:134:3::10]:38988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cYWlG-0008OT-TD
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cYWlG-0003Ti-5L
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:38:10 -0500
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
	<20170122142959.GA12419@lemon.Home>
	<ff2fd02a-09ea-a28f-eb6e-e1858efff552@redhat.com>
	<20170124120957.GC13714@lemon.Home>
From: John Snow <jsnow@redhat.com>
Message-ID: <e63adc3a-ca01-705a-c21a-d3ead5eb4472@redhat.com>
Date: Tue, 31 Jan 2017 06:37:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170124120957.GC13714@lemon.Home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/3] scsi-generic and
 BLKSECTGET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mreitz@redhat.com, kwolf@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 01/24/2017 07:09 AM, Fam Zheng wrote:
> On Tue, 01/24 12:23, Paolo Bonzini wrote:
>>
>>
>> On 22/01/2017 15:29, Fam Zheng wrote:
>>> On Fri, 01/20 17:25, Eric Farman wrote:
>>>> Changes:
>>>>  v2->v3:
>>>>   - Move byte/sector conversions to patch 2 [Fam Zheng]
>>>>   - Rename "max_sectors" when holding a byte value [Fam Zheng]
>>>>  v1->v2:
>>>>   - Patch 3, make hdev_get_max_transfer_length return bytes [Fam Zheng]
>>>
>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>
>> Looks good, who's merging this? :)
> 
> All I know is not me :) Adding Kevin and Max who maintain block/file-posix.c.
> 
> Fam
> 

Kevin's traveling for DevConf.cz, so how about Max? :)
