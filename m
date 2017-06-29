Received: from eggs.gnu.org ([2001:4830:134:3::10]:40627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQcW7-0005vs-AP
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQcW3-0007OA-Br
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:42:07 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQcW3-0007O4-6U
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:42:03 -0400
Received: by mail-qt0-x244.google.com with SMTP id m54so9430941qtb.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:42:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170629010300.2848-1-f4bug@amsat.org>
	<20170629010300.2848-6-f4bug@amsat.org>
	<9403a3d0-41f6-add2-04fd-12034fe7699a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <daa8e1ba-9d79-e5cf-a7d8-a459acf0bd3c@amsat.org>
Date: Thu, 29 Jun 2017 13:41:58 -0300
MIME-Version: 1.0
In-Reply-To: <9403a3d0-41f6-add2-04fd-12034fe7699a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH RESEND 5/8] tcg/tci: enable bswap16_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>

On 06/29/2017 01:29 PM, Eric Blake wrote:
> On 06/28/2017 08:02 PM, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Double-sob seems odd.
> 

eh you never know... I need to improve my mailing skills :|

>> ---
>>   tcg/tci.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
> 
> Otherwise,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks.
