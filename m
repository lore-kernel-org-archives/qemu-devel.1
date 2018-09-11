Received: from eggs.gnu.org ([2001:4830:134:3::10]:37960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzpaS-0005CC-SQ
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzpaL-0001gP-BG
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:48:38 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fzpaF-0001Yi-6R
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:48:29 -0400
Received: by mail-pl1-x641.google.com with SMTP id g2-v6so10917979plo.2
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 13:48:22 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180911202823.21657-1-cota@braap.org>
	<20180911202823.21657-5-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b512699d-4776-d473-4532-d82bf41f9281@twiddle.net>
Date: Tue, 11 Sep 2018 13:48:19 -0700
MIME-Version: 1.0
In-Reply-To: <20180911202823.21657-5-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 04/13] target/i386: move cpu_T1 to
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
>  target/i386/translate.c | 341 ++++++++++++++++++++--------------------
>  1 file changed, 170 insertions(+), 171 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
