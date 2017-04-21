Received: from eggs.gnu.org ([2001:4830:134:3::10]:46311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1XE9-0004P3-9Z
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1XE8-00085K-Gk
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:59:53 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:34324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1XE8-000857-9v
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:59:52 -0400
Received: by mail-wm0-x22e.google.com with SMTP id r190so7030365wme.1
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 04:59:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1492753213-26516-1-git-send-email-armbru@redhat.com>
References: <1492753213-26516-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Apr 2017 12:59:30 +0100
Message-ID: <CAFEAcA-OjSb1XUWMRO+WaLCXZ8bKi+=PNEEd6g3-cGJxq+N4TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/4] qdev patches for 2017-04-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 April 2017 at 06:40, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 359c41abe32638adad503e386969fa428cecff52:
>
>   Update version for v2.9.0 release (2017-04-20 15:31:34 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qdev-2017-04-21
>
> for you to fetch changes up to 08f00df4f4b8b4e38ad620477cc90cf5f73832d9:
>
>   qdev: remove cannot_destroy_with_object_finalize_yet (2017-04-21 07:18:34 +0200)
>
> ----------------------------------------------------------------
> qdev patches for 2017-04-21
>
> ----------------------------------------------------------------
> Laurent Vivier (4):
>       arm: remove remaining cannot_destroy_with_object_finalize_yet
>       ppc: remove cannot_destroy_with_object_finalize_yet
>       versatile: remove cannot_destroy_with_object_finalize_yet
>       qdev: remove cannot_destroy_with_object_finalize_yet

Applied, thanks.

-- PMM
