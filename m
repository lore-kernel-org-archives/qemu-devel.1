Received: from eggs.gnu.org ([2001:4830:134:3::10]:38832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1elLBD-0006zI-Nj
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1elLBA-0002uu-IQ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:58:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1elLBA-0002sZ-DG
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:58:24 -0500
Date: Mon, 12 Feb 2018 18:58:19 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180212205819.GT13981@localhost.localdomain>
References: <20180212185347.8433-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212185347.8433-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/7] machine/CPU queue, 2018-02-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>

On Mon, Feb 12, 2018 at 04:53:40PM -0200, Eduardo Habkost wrote:
> The following changes since commit 8e3fb8029efaf220ab48290cdb5151c682227030:
> 
>   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2018-02-12 13:00:03 +0000)
> 
> are available in the Git repository at:
> 
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> 
> for you to fetch changes up to 71479144b8c743f0f2b7cdf831f65edc6931c3cf:
> 
>   cpu: drop unnecessary NULL check and cpu_common_class_by_name() (2018-02-12 15:17:05 -0200)
> 
> ----------------------------------------------------------------
> machine/CPU queue, 2018-02-12
> 
> ----------------------------------------------------------------

Please ignore this.  I just noticed I ran testing on the wrong
branch (before the last rebase), and this conflicts with QAPI
changes merged last Friday.  Sorry for the noise.

-- 
Eduardo
