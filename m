Received: from eggs.gnu.org ([2001:4830:134:3::10]:50791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHpbO-0007m5-W0
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHpbL-0008Jq-Rp
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:28:02 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39451)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gHpbL-0008IH-Gm
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:27:59 -0400
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-11-cota@braap.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a9b4b226-50c9-b697-3ab1-eee13c890e39@vivier.eu>
Date: Wed, 31 Oct 2018 13:27:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-11-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 11/71] m68k: convert to
 helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

On 25/10/2018 16:45, Emilio G. Cota wrote:
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/m68k/translate.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
