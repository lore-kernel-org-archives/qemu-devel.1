Received: from eggs.gnu.org ([2001:4830:134:3::10]:57670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRTY3-0002Fk-SH
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 21:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRTY3-0002mf-2m
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 21:19:39 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865704378.17063.12646195470292499503.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5542bcb6-384c-95db-83ad-29257238fd91@twiddle.net>
Date: Sat, 1 Jul 2017 18:19:30 -0700
MIME-Version: 1.0
In-Reply-To: <149865704378.17063.12646195470292499503.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 20/29] target/arm: [tcg,
 a64] Port to insn_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/28/2017 06:37 AM, Lluís Vilanova wrote:
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova<vilanova@ac.upc.edu>
> ---
>   target/arm/translate-a64.c |   11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
