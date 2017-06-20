Received: from eggs.gnu.org ([2001:4830:134:3::10]:40882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dNLY2-0003Uf-JC
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dNLY1-00067Z-49
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:58:34 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dNLY0-00065v-T1
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:58:33 -0400
Received: by mail-wr0-x230.google.com with SMTP id r103so96782720wrb.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 08:58:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497903262-18626-1-git-send-email-chugh.ishani@research.iiit.ac.in>
References: <1497903262-18626-1-git-send-email-chugh.ishani@research.iiit.ac.in>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 20 Jun 2017 16:58:30 +0100
Message-ID: <CAJSP0QXN4tJP56LyENv9DgBPeYzTuoWjgfG+FHrH=FU5U0wufw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] Add manpage for QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Jun 19, 2017 at 9:14 PM, Ishani Chugh
<chugh.ishani@research.iiit.ac.in> wrote:
> qemu-backup will be a command-line tool for performing full and incremental disk backups on running
> VMs.  It is intended as a reference implementation for management stack and backup developers to
> see QEMU's backup features in action. The following commit is an initial implementation of manpage
> listing the commands which the backup tool will support.
>
> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> ---
>  Makefile                        |   2 +-
>  contrib/backup/qemu-backup.texi | 139 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 140 insertions(+), 1 deletion(-)
>  create mode 100644 contrib/backup/qemu-backup.texi

Hi Ishani,
Did you see my review comments on v2?  This patch does not address my feedback.

Stefan
