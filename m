Received: from eggs.gnu.org ([2001:4830:134:3::10]:55956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRTJO-0005X0-1G
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 21:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRTJN-0003RR-6p
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 21:04:30 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865583044.17063.6916936084139965036.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f12a2201-cc2b-1cd3-3bf9-94aea69a163a@twiddle.net>
Date: Sat, 1 Jul 2017 18:04:20 -0700
MIME-Version: 1.0
In-Reply-To: <149865583044.17063.6916936084139965036.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 15/29] target/arm: [tcg] Port to
 init_disas_context
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

On 06/28/2017 06:17 AM, Lluís Vilanova wrote:
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova<vilanova@ac.upc.edu>
> ---
>   target/arm/translate.c |   85 +++++++++++++++++++++++++++---------------------
>   1 file changed, 47 insertions(+), 38 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
