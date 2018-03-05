Received: from eggs.gnu.org ([2001:4830:134:3::10]:39633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1esypN-0001g1-GX
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 17:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1esypI-0004wB-KO
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 17:43:29 -0500
Date: Mon, 5 Mar 2018 17:43:22 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180305224322.GA16890@flamenco>
References: <1519944838-12430-1-git-send-email-cota@braap.org>
	<0c745832-224a-03bb-737b-69dba8419055@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c745832-224a-03bb-737b-69dba8419055@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv1 00/14] Translation loop conversion for
 sh4/sparc/mips/s390x/openrisc targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, Stafford Horne <shorne@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>

On Mon, Mar 05, 2018 at 21:58:52 +0000, Mark Cave-Ayland wrote:
> I don't have enough knowledge of TCG internals to review this myself,
> however I can run it through my complete set of OpenBIOS test images for
> qemu-system-sparc and qemu-system-sparc64 if that helps?

That would be appreciated -- I only tested sparc64 by booting a NetBSD
guest.

Thanks,

		Emilio
