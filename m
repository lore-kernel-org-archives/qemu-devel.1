Received: from eggs.gnu.org ([2001:4830:134:3::10]:35883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzpWj-0000Y0-JM
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzpWf-0006bK-GF
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:44:49 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:39214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fzpWf-0006a0-0o
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:44:45 -0400
Received: by mail-pg1-x532.google.com with SMTP id i190-v6so12843519pgc.6
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 13:44:44 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180911202823.21657-1-cota@braap.org>
	<20180911202823.21657-2-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8ee7b314-5fd4-c70b-ca38-6616704e35d8@twiddle.net>
Date: Tue, 11 Sep 2018 13:44:41 -0700
MIME-Version: 1.0
In-Reply-To: <20180911202823.21657-2-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/13] target/i386: move cpu_cc_srcT to
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
>  target/i386/translate.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
