Received: from eggs.gnu.org ([2001:4830:134:3::10]:45358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cj4I1-0007oi-F2
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cj4I0-0003zx-KU
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:27:33 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cj4I0-0003zf-Du
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:27:32 -0500
Received: by mail-wr0-x22a.google.com with SMTP id l37so30110759wrc.1
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 05:27:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488272804-27144-1-git-send-email-kraxel@redhat.com>
References: <1488272804-27144-1-git-send-email-kraxel@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 1 Mar 2017 13:27:30 +0000
Message-ID: <CAJSP0QVhb6FPh9HaC--7vqRgetuBQNvYt9BxeCp9KaNOTfLe8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] seabios: update to 1.10.2 release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Tue, Feb 28, 2017 at 9:06 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Our seabios.git mirror @ qemu.org seems to not sync properly.  The
> commit isn't there even though it was pushed a few days ago already
> (only the tag was pushed today).  John, can you have a look please?
> master branch, *-stable branches and all tags should be mirrored.

Hi Gerd,
It looks like the git mirrors weren't updating.  I kicked it and the
necessary commit is now in the QEMU seabios.git mirror repo.

It should be safe to merge this pull request now.

Stefan
