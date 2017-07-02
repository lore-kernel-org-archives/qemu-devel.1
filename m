Received: from eggs.gnu.org ([2001:4830:134:3::10]:54780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRT7g-0001uJ-LB
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRT7d-0008NN-Iw
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:52:24 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dRT7d-0008N3-E5
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:52:21 -0400
Received: by mail-qk0-x241.google.com with SMTP id 91so20040355qkq.1
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 17:52:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865534644.17063.5754453204442221401.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ea32f1c5-d598-82e2-db4c-28c2fb0a68dc@twiddle.net>
Date: Sat, 1 Jul 2017 17:52:17 -0700
MIME-Version: 1.0
In-Reply-To: <149865534644.17063.5754453204442221401.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 13/29] target/i386: [tcg] Port to
 generic translation framework
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

On 06/28/2017 06:09 AM, Lluís Vilanova wrote:
> Signed-off-by: Lluís Vilanova<vilanova@ac.upc.edu>
> ---
>   target/i386/translate.c |  120 +++++++----------------------------------------
>   1 file changed, 18 insertions(+), 102 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
