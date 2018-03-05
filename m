Received: from eggs.gnu.org ([2001:4830:134:3::10]:53041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1essnE-0007RI-V1
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1essnD-0000ji-WC
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:16:52 -0500
References: <20180302134917.25526-1-eblake@redhat.com>
	<53df9dc5-6cb0-c7ef-2c07-923e59aa9b60@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <babcfd62-7867-7aef-9900-efab134272b4@redhat.com>
Date: Mon, 5 Mar 2018 10:16:39 -0600
MIME-Version: 1.0
In-Reply-To: <53df9dc5-6cb0-c7ef-2c07-923e59aa9b60@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: Mark all tests executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

On 03/05/2018 09:56 AM, Max Reitz wrote:
> On 2018-03-02 14:49, Eric Blake wrote:
>> The majority of our iotests have the executable bit set; fix the
>> few outliers for consistency.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
> 
> I think 124 is missing.

Good catch.  Yes, it is, and I'll spin v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
