Received: from eggs.gnu.org ([209.51.188.92]:59817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goZ9l-0000fi-HW
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goZ9j-00081n-Ep
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:34:49 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36001)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goZ9j-000800-4d
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:34:47 -0500
Date: Tue, 29 Jan 2019 14:34:43 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190129193443.GA25373@flamenco>
References: <20180709014953.26230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709014953.26230-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] tests/tcg/multiarch/linux-test: Fix error
 check for shmat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Sun, Jul 08, 2018 at 18:49:53 -0700, Richard Henderson wrote:
> The error indicator for this syscall is -1, not 0.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
