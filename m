Received: from eggs.gnu.org ([2001:4830:134:3::10]:45100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0syg-0000bK-0y
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0syc-0006rG-2b
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:05:46 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39447)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f0syb-0006qC-T8
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:05:41 -0400
Date: Tue, 27 Mar 2018 14:05:40 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180327180540.GE2693@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sh8l92fo.fsf@linaro.org>
 <87tvt192fy.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v1 05/14] softfloat: add float32_is_normal
 and float64_is_normal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Tue, Mar 27, 2018 at 12:34:57 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > This paves the way for upcoming work.
> >
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

(snip)
On Tue, Mar 27, 2018 at 12:35:07 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > This paves the way for upcoming work.
> >
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

In v2 I merged these two into the same commit, so I've added your
R-b tag to the corresponding commit in v3.

Thanks,

		Emilio
