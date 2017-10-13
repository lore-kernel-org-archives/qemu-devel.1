Received: from eggs.gnu.org ([2001:4830:134:3::10]:53822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1e2vAZ-00061V-EJ
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1e2vAY-0006SX-6S
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:18:11 -0400
MIME-Version: 1.0
In-Reply-To: <7e611573-e25e-65cc-2222-f7d2429bf924@redhat.com>
References: <20171013012455.10737-1-famz@redhat.com>
	<20171013012455.10737-3-famz@redhat.com>
	<7e611573-e25e-65cc-2222-f7d2429bf924@redhat.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 13 Oct 2017 10:17:47 +0200
Message-ID: <CACXAS8ArkNy7J_gtT0A8pwLWfnr6EM467Y9VzPZRM3WnXYAxjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] MAINTAINERS: Drop Sun4v nonexistent
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org

On Fri, Oct 13, 2017 at 10:08 AM, Thomas Huth <thuth@redhat.com> wrote:
> On 13.10.2017 03:24, Fam Zheng wrote:
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>>  MAINTAINERS | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index da3c78df47..731c5c7ec2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -778,7 +778,6 @@ F: pc-bios/openbios-sparc64
>>  Sun4v
>>  M: Artyom Tarasenko <atar4qemu@gmail.com>
>>  S: Maintained
>> -F: hw/sparc64/sun4v.c
>
> I guess you should rather replace that one with:
>
> hw/sparc64/niagara.c
>
> Artyom, is that right?

Yes, please.

Thanks!


-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
