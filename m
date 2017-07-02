Received: from eggs.gnu.org ([2001:4830:134:3::10]:52313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRSib-0003ay-Du
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRSiZ-00044P-Q1
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:26:29 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dRSiZ-00044J-LQ
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:26:27 -0400
Received: by mail-qk0-x241.google.com with SMTP id 91so20000893qkq.1
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 17:26:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865413649.17063.7416035795116708956.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b9247aab-1eed-a25a-87f8-70abad2b39b4@twiddle.net>
Date: Sat, 1 Jul 2017 17:26:24 -0700
MIME-Version: 1.0
In-Reply-To: <149865413649.17063.7416035795116708956.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 08/29] target/i386: [tcg] Refactor
 insn_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/28/2017 05:48 AM, Lluís Vilanova wrote:
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova<vilanova@ac.upc.edu>
> ---
>   target/i386/translate.c |    9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
