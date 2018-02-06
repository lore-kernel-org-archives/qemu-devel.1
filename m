Received: from eggs.gnu.org ([2001:4830:134:3::10]:57457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejBgt-0005AK-6Q
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejBgs-0000eq-5h
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:26:15 -0500
Date: Tue, 6 Feb 2018 20:26:00 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180206222600.GF13301@localhost.localdomain>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
	<1516694904-64879-25-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516694904-64879-25-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 24/25] cpu: get rid of unused cpu_init()
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Yongbok Kim <yongbok.kim@mips.com>, Marek Vasut <marex@denx.de>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On Tue, Jan 23, 2018 at 09:08:23AM +0100, Igor Mammedov wrote:
> cpu_init(cpu_model) were replaced by cpu_create(cpu_type) so
> no users are left, remove it.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
