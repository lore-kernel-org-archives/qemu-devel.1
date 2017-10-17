Received: from eggs.gnu.org ([2001:4830:134:3::10]:45904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4bfu-000594-RA
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 19:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4bfr-00085w-Nf
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 19:53:30 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36901)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4bfr-00085N-HF
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 19:53:27 -0400
Date: Tue, 17 Oct 2017 19:53:25 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171017235325.GA18359@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-21-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171016172609.23422-21-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 20/50] qom: Introduce
 CPUClass.tcg_initialize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Mon, Oct 16, 2017 at 10:25:39 -0700, Richard Henderson wrote:
> Move target cpu tcg initialization to common code,
> called from cpu_exec_realizefn.
> 
> Cc: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Much cleaner!

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
