Received: from eggs.gnu.org ([2001:4830:134:3::10]:52690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e6gFM-0005ne-GN
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e6gFH-0000Kd-Nu
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:10:40 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45879)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e6gFH-0000KW-Jm
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:10:35 -0400
Date: Mon, 23 Oct 2017 13:10:34 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171023171034.GB6901@flamenco>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
	<20171020232023.15010-17-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171020232023.15010-17-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v7 16/52] tcg: Introduce tcgv_{i32, i64,
 ptr}_{arg, temp}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, pbonzini@redhat.com

On Fri, Oct 20, 2017 at 16:19:47 -0700, Richard Henderson wrote:
> Transform TCGv_* to an "argument" or a temporary.
> For now, an argument is simply the temporary index.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
