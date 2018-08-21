Received: from eggs.gnu.org ([2001:4830:134:3::10]:59275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fsEj7-00074b-QG
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 18:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fsEj4-0003m0-GN
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 18:02:13 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41797)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fsEiw-0003jZ-Se
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 18:02:05 -0400
Date: Tue, 21 Aug 2018 18:01:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180821220159.GB29425@flamenco>
References: <20180821142704.18783-1-richard.henderson@linaro.org>
	<20180821142704.18783-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821142704.18783-5-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] target/arm: Check HAVE_CMPXCHG128
 at transate time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, Aug 21, 2018 at 07:27:03 -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

$subject: s/transate/translate/

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
