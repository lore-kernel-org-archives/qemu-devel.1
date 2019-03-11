Received: from eggs.gnu.org ([209.51.188.92]:49307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3LNh-00043E-2m
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3LFC-0002YU-Qg
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:45:32 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:46551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h3LFA-0002So-TN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:45:30 -0400
Received: by mail-oi1-x235.google.com with SMTP id j10so3632880oij.13
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 06:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190311082619.17966-1-kraxel@redhat.com>
In-Reply-To: <20190311082619.17966-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2019 13:45:13 +0000
Message-ID: <CAFEAcA_PbFmhoDPK3PdbQJQj+a0UqO6JqFZb5BofJjcH=6d7xQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Ui 20190311 v2 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 11 Mar 2019 at 08:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit e2a18635a400b0e68679614132e9ef6316105590:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-03-08' into staging (2019-03-09 20:55:44 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20190311-v2-pull-request
>
> for you to fetch changes up to 0143840771548e8ffece831398d745880ddfa080:
>
>   monitor: deprecate acl_show, acl_reset, acl_policy, acl_add, acl_remove (2019-03-11 08:39:02 +0100)
>
> ----------------------------------------------------------------
> curses: wide char input support.
> vnc: acl update, stall fix.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
