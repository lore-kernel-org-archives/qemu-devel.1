Received: from eggs.gnu.org ([2001:4830:134:3::10]:58718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpytV-0005RQ-50
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpytQ-0008J8-Lj
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:39:05 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:33771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpytQ-0008In-DY
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:39:00 -0400
Received: by mail-wr0-x22b.google.com with SMTP id a43so207283wrc.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 08:39:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170906184133.25524-1-dgilbert@redhat.com>
References: <20170906184133.25524-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 16:38:38 +0100
Message-ID: <CAFEAcA8-UJ_K7tCT62=AYq0aNknMT_PajLLwxcqO+LNE29L4LA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

On 6 September 2017 at 19:41, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit b07d1c2f5607489d4d4a6a65ce36a3e896ac065e:
>
>   Revert "kvm: use DIV_ROUND_UP" (2017-09-05 18:55:40 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20170906a
>
> for you to fetch changes up to a31fedeed764ce0b0d6097d4334c5770e74641a0:
>
>   migration: dump str in migrate_set_state trace (2017-09-06 16:36:38 +0100)
>
> ----------------------------------------------------------------
> migration pull 2017-09-06
>

Applied, thanks.

-- PMM
