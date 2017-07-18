Received: from eggs.gnu.org ([2001:4830:134:3::10]:51777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXG4B-0007Sb-GE
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXG4A-0005fO-Km
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:08:43 -0400
Date: Mon, 17 Jul 2017 20:08:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718000836.GD30851@flamenco>
References: <20170711175937.23140-1-alex.bennee@linaro.org>
	<20170711175937.23140-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170711175937.23140-4-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 3/6] target/arm/translate.h: expand
 comment on DISAS_EXIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, rth@twiddle.net, qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>

On Tue, Jul 11, 2017 at 18:59:34 +0100, Alex Bennée wrote:
> We already have an exit condition, DISAS_UPDATE which will exit the
> run-loop. Expand on the difference with DISAS_EXIT in the comments.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
