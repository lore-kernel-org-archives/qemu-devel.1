Received: from eggs.gnu.org ([2001:4830:134:3::10]:40397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cQrGZ-0002Bj-C1
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 02:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cQrGV-00069P-EE
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 02:54:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cQrGV-00069F-8H
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 02:54:43 -0500
References: <1478772703-28185-1-git-send-email-thuth@redhat.com>
	<1478772703-28185-7-git-send-email-thuth@redhat.com>
	<20170110053133-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <362c2ee4-b230-d407-c3eb-af80fbfafa96@redhat.com>
Date: Tue, 10 Jan 2017 08:54:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170110053133-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 6/6] MAINTAINERS: Remove obsolete stable
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 10.01.2017 04:32, Michael S. Tsirkin wrote:
> On Thu, Nov 10, 2016 at 11:11:43AM +0100, Thomas Huth wrote:
>> There are only very old and orphaned stable branches listed
>> in the MAINTAINERS file - so this section is pretty useless
>> nowadays. Let's remove it.
>>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> 
> Could you add some kind of entry for stable though?
> Otherwise people won't know which address to CC.

I think that's a question to Michael Roth - whether such an entry should
be added and how it should look like.

 Thomas


>> ---
>>  MAINTAINERS | 22 ----------------------
>>  1 file changed, 22 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d8575ab..4a60579 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1574,28 +1574,6 @@ F: tcg/tci/
>>  F: tci.c
>>  F: disas/tci.c
>>  
>> -Stable branches
>> ----------------
>> -Stable 1.0
>> -L: qemu-stable@nongnu.org
>> -T: git git://git.qemu-project.org/qemu-stable-1.0.git
>> -S: Orphan
>> -
>> -Stable 0.15
>> -L: qemu-stable@nongnu.org
>> -T: git git://git.qemu-project.org/qemu-stable-0.15.git
>> -S: Orphan
>> -
>> -Stable 0.14
>> -L: qemu-stable@nongnu.org
>> -T: git git://git.qemu-project.org/qemu-stable-0.14.git
>> -S: Orphan
>> -
>> -Stable 0.10
>> -L: qemu-stable@nongnu.org
>> -T: git git://git.qemu-project.org/qemu-stable-0.10.git
>> -S: Orphan
>> -
>>  Block drivers
>>  -------------
>>  VMDK
>> -- 
>> 1.8.3.1
>>
