Received: from eggs.gnu.org ([2001:4830:134:3::10]:55637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnDys-0004yt-PS
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 21:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnDyp-0006NH-Lv
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 21:09:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnDyp-0006Me-En
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 21:09:11 -0400
Date: Thu, 31 Aug 2017 09:09:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170831010903.GA17741@lemon.lan>
References: <1504113297-22052-1-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504113297-22052-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, jsnow@redhat.com

On Wed, 08/30 22:44, Ishani Chugh wrote:
> This patch series is intended to introduce QEMU Backup tool.
> qemu-backup will be a command-line tool for performing full and
> incremental disk backups on running VMs. It is intended as a
> reference implementation for management stack and backup developers
> to see QEMU's backup features in action.
> This patch series contains three patches,
>                1) QEMU Backup command line tool.
>                2) Test for full backup.
>                3) Manpage for the tool.
> v3:
> * Added versioning in config file
> * Replace location by qemu-img convert in restore
> * Removed incremental backup documentation from manpage

Reviewed-by: Fam Zheng <famz@redhat.com>
