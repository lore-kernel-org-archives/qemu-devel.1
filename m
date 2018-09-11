Received: from eggs.gnu.org ([2001:4830:134:3::10]:36223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzpXj-0001N1-9c
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzpXe-0007VC-53
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:45:50 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:42908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fzpXd-0007UK-US
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:45:46 -0400
Received: by mail-pg1-x52f.google.com with SMTP id y4-v6so12834635pgp.9
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 13:45:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180911202823.21657-1-cota@braap.org>
	<20180911202823.21657-3-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d5c4d194-8c54-4f30-703a-b368954ec206@twiddle.net>
Date: Tue, 11 Sep 2018 13:45:42 -0700
MIME-Version: 1.0
In-Reply-To: <20180911202823.21657-3-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/13] target/i386: move cpu_A0 to
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
>  target/i386/translate.c | 472 ++++++++++++++++++++--------------------
>  1 file changed, 236 insertions(+), 236 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
