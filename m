Received: from eggs.gnu.org ([209.51.188.92]:35281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gm5l9-0007KM-7r
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 18:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gm5ky-0006CM-Sk
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 18:47:01 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:39505)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gm5ky-0006Bm-N9
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 18:47:00 -0500
Date: Tue, 22 Jan 2019 18:46:57 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190122234657.GB9839@flamenco>
References: <20190122215016.18697-1-alex.bennee@linaro.org>
	<20190122215016.18697-12-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190122215016.18697-12-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 11/11] tests/Makfile: add
 check-softfloat rule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Tue, Jan 22, 2019 at 21:50:16 +0000, Alex Bennée wrote:
> This adds a rule to run all of our softfloat tests. It is included as
> a pre-requisite to check-tcg and check-unit as well.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

You might want to fix the commit title with  s/Makfile/Makefile/

That said,
Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,

		Emilio
