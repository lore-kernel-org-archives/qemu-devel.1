Received: from eggs.gnu.org ([2001:4830:134:3::10]:37817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0H9-00088p-0U
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0H4-0005bt-DR
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:07:34 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:36599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0H4-0005bd-8z
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:07:30 -0400
Received: by mail-qt0-x22c.google.com with SMTP id b52so821871qtb.3
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 10:07:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170901125742.4249-1-kraxel@redhat.com>
	<ff830cfa-a8fa-0852-596f-4fc535512b1c@amsat.org>
	<1504772696.15653.5.camel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b2d705c1-d86c-ba64-3af2-56aabe08c32b@amsat.org>
Date: Thu, 7 Sep 2017 14:07:26 -0300
MIME-Version: 1.0
In-Reply-To: <1504772696.15653.5.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 0/5] Vga 20170901 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

Hi Gerd,

On 09/07/2017 05:24 AM, Gerd Hoffmann wrote:
>    Hi,
> 
> I'v been reviewing your patches and took some notes but didn't
> finished,
>> since there is something bothering me.
>> I see they haven't been reviewed yet, can you hold this PR and wait
>> the
>> weekend?
> 
> Ping.  Care to share your concerns?  Weekend is long over ...

I apologize it took me so long :/ I had doubts about patches 1 & 2 but 
it could clarify them.

Do you notice performance degradations since patch 2?

Your series is OK, if you ever resend rebased you can add:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Regards,

Phil.
