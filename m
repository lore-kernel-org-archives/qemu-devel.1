Received: from eggs.gnu.org ([2001:4830:134:3::10]:40453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1e2w0z-0006Wt-Kk
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1e2w0y-0005ce-N6
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:12:21 -0400
MIME-Version: 1.0
In-Reply-To: <00b58d8d-11d2-894a-6e87-f65585435a0b@redhat.com>
References: <20171013085355.7563-1-famz@redhat.com>
	<20171013085355.7563-3-famz@redhat.com>
	<00b58d8d-11d2-894a-6e87-f65585435a0b@redhat.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 13 Oct 2017 11:11:59 +0200
Message-ID: <CACXAS8B7kf8Y4hQu0+ZXXz=b0TLnzPkerC1B7fhVVxXg8nR4cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] MAINTAINERS: Fix Sun4v file
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

On Fri, Oct 13, 2017 at 10:58 AM, Thomas Huth <thuth@redhat.com> wrote:
> On 13.10.2017 10:53, Fam Zheng wrote:
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 18ddaf4070..3938ccbf8a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -778,7 +778,7 @@ F: pc-bios/openbios-sparc64
>>  Sun4v
>>  M: Artyom Tarasenko <atar4qemu@gmail.com>
>>  S: Maintained
>> -F: hw/sparc64/sun4v.c
>> +F: hw/sparc64/niagara.c
>>  F: hw/timer/sun4v-rtc.c
>>  F: include/hw/timer/sun4v-rtc.h
>>
>>
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

 Acked-By: Artyom Tarasenko <atar4qemu@gmail.com>

-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
