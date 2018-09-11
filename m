Received: from eggs.gnu.org ([2001:4830:134:3::10]:39841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzpg7-00018C-K5
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzpg4-0005DV-AL
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:54:31 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:44145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fzpg3-00057b-Oz
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:54:28 -0400
Received: by mail-pg1-x529.google.com with SMTP id r1-v6so12835230pgp.11
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 13:54:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180911202823.21657-1-cota@braap.org>
	<20180911202823.21657-9-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <df8b4dee-c46c-b827-c486-3bd7ae346946@twiddle.net>
Date: Tue, 11 Sep 2018 13:54:13 -0700
MIME-Version: 1.0
In-Reply-To: <20180911202823.21657-9-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/13] target/i386: move cpu_ptr1 to
 DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 09/11/2018 01:28 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/i386/translate.c | 52 ++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
