Received: from eggs.gnu.org ([209.51.188.92]:51712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1TYz-0003nv-5y
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:14:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1TYx-0007eH-Vs
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:14:13 -0500
References: <20190213130240.15492-1-armbru@redhat.com>
	<87o96r3q5d.fsf@dusky.pond.sub.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a17c244f-e75a-cac5-4a56-5c2fdee7262f@vivier.eu>
Date: Wed, 6 Mar 2019 11:13:48 +0100
MIME-Version: 1.0
In-Reply-To: <87o96r3q5d.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] build: Correct explanation
 of unnest-vars example
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org

On 04/03/2019 11:11, Markus Armbruster wrote:
> I guess this could go via -trivial.
> 
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> Cc: Fam Zheng <fam@euphon.net>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  rules.mak | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/rules.mak b/rules.mak
>> index 86e033d815..19f3d2c126 100644
>> --- a/rules.mak
>> +++ b/rules.mak
>> @@ -327,7 +327,7 @@ endef
>>  #     ../water/ice.mo-libs = -licemaker
>>  #     ../water/ice.mo-objs = ../water/ice1.o ../water/ice2.o
>>  #
>> -# Note that 'hot' didn't include 'season/' in the input, so 'summer.o' is not
>> +# Note that 'hot' didn't include 'water/' in the input, so 'steam.o' is not
>>  # included.
>>  #
>>  define unnest-vars
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
