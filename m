Received: from eggs.gnu.org ([2001:4830:134:3::10]:33604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f4Q3s-0003Ys-IP
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f4Q3l-0000BX-Tp
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:01:44 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:34062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f4Q3l-0000AS-Eu
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:01:37 -0400
References: <1522883475-27858-1-git-send-email-cota@braap.org>
	<1522883475-27858-5-git-send-email-cota@braap.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <eb51406e-c966-76de-fb84-e53e1d28a524@mail.uni-paderborn.de>
Date: Fri, 6 Apr 2018 14:01:21 +0200
MIME-Version: 1.0
In-Reply-To: <1522883475-27858-5-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 04/15] softfloat: add float{32,
 64}_is_{de, }normal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On 04/05/2018 01:11 AM, Emilio G. Cota wrote:
> This paves the way for upcoming work.
> 
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/fpu/softfloat.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
