Received: from eggs.gnu.org ([2001:4830:134:3::10]:45848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cefbY-0004Ff-FX
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 05:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cefbV-0006YW-Af
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 05:17:32 -0500
Date: Fri, 17 Feb 2017 18:17:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170217101725.GB3468@lemon.lan>
References: <20170216085857.23501-1-snaipe@diacritic.io>
	<20170217085800.28873-1-snaipe@diacritic.io>
	<CAK_MOSfBOJn6Zqo2Z9E8pLZLsuTJZ37HQo_1bp4XdU3iG55D1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK_MOSfBOJn6Zqo2Z9E8pLZLsuTJZ37HQo_1bp4XdU3iG55D1A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] syscall: fixed mincore(2) not failing with
 ENOMEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Franklin \"Snaipe\" Mathieu" <snaipe@diacritic.io>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, snaipe@arista.com, Riku Voipio <riku.voipio@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, 02/17 09:00, Franklin "Snaipe" Mathieu wrote:
> Ignore this patch, this was sent again by mistake.

Hi Franklin, thanks for the re-submission. Next time please send consecutive
versions as top-level threads instead of replies to previous versions, with
proper 'v2", "v3" tags in the subject.

Fam
