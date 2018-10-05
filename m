Received: from eggs.gnu.org ([2001:4830:134:3::10]:49472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8QCy-0002XL-7i
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8QCv-00061f-3h
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:31:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8QCu-0005wx-S1
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:31:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id 63-v6so13554325wra.11
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:31:52 -0700 (PDT)
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-2-crosa@redhat.com>
	<5616e4d4-938c-4e5f-6fe0-64e52d2fe6a7@redhat.com>
	<0a405ae6-d69a-8e04-e3dc-3b7883447248@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e5944b57-0778-b8ae-6805-0678970a12fa@redhat.com>
Date: Fri, 5 Oct 2018 15:31:49 +0200
MIME-Version: 1.0
In-Reply-To: <0a405ae6-d69a-8e04-e3dc-3b7883447248@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/10] qemu-img.c: comment typo fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>

On 04/10/2018 18:53, Cleber Rosa wrote:> On 10/4/18 12:48 PM, Eric Blake
wrote:
>> On 10/4/18 11:18 AM, Cleber Rosa wrote:
>>> A trivial comment typo fix.
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>   qemu-img.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/qemu-img.c b/qemu-img.c
>>> index b12f4cd19b..a96b76c187 100644
>>> --- a/qemu-img.c
>>> +++ b/qemu-img.c
>>> @@ -1085,7 +1085,7 @@ static int64_t find_nonzero(const uint8_t *buf,
>>> int64_t n)
>>>   }
>>>     /*
>>> - * Returns true iff the first sector pointed to by 'buf' contains at
>>> least
>>> + * Returns true if the first sector pointed to by 'buf' contains at
>>> least
>>
>> NACK.  You're not the first person to propose this change.  However,
>> "iff" is an English word (albeit archaic) which is shorthand for "if and
>> only if", which has a distinct logical meaning separate from the weaker
>> "if".  Spelling it out in longhand instead of calling it a typo is
>> probably acceptable, though.
>>
> 
> Wow, thanks for the explanation.  I agree that spelling it out is a good
> option, as it'll probably prevent other people from falling into the
> same "language trap" as I did.

https://lists.gnu.org/archive/html/qemu-devel/2011-06/msg01269.html

https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04200.html

;)
