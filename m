Received: from eggs.gnu.org ([2001:4830:134:3::10]:36564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUGvo-0006uA-Od
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 14:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUGvl-0006BA-LR
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 14:27:44 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60599)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dUGvl-000699-BY
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 14:27:41 -0400
Date: Sun, 9 Jul 2017 14:27:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170709182739.GA24170@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499586614-20507-1-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH 00/22] tcg: per-thread TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On Sun, Jul 09, 2017 at 03:49:52 -0400, Emilio G. Cota wrote:
> The series applies on top of the current master (b11365867568).

It's a lot of patches -- you can fetch them from:
  https://github.com/cota/qemu/commits/multi-tcg

Note that there's a patch in the branch there that is not part
of the patchset ("scripts: add "git.orderfile" for ordering ...")

		E.
