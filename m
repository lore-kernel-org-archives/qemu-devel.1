Received: from eggs.gnu.org ([2001:4830:134:3::10]:39009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcuz0-0001dc-Nn
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcuz0-0005nK-1K
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:50:46 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dcuyz-0005mo-Oc
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:50:45 -0400
Received: by mail-wr0-x229.google.com with SMTP id v105so19744023wrb.0
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 07:50:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170802135834.1455-1-dgilbert@redhat.com>
References: <20170802135834.1455-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Aug 2017 15:50:23 +0100
Message-ID: <CAFEAcA96v4PaTD=PXjqBRALCpcCZVjEckUwybVXu15Zm2_XqDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

On 2 August 2017 at 14:58, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit d3d183a638d6a3ead515618a6547b3f80d39fcb9:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-08-02 09:49:02 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20170802a
>
> for you to fetch changes up to 8bd9c4e6c565c566a6cba3470cb2d4ea63994143:
>
>   io: fix qio_channel_socket_accept err handling (2017-08-02 11:27:44 +0100)
>
> ----------------------------------------------------------------
> Migration pull 2017-08-02
>
> Just minor fixes for 2.10

Applied, thanks.

-- PMM
