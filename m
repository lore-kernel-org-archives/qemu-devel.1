Received: from eggs.gnu.org ([2001:4830:134:3::10]:39525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2txd-0004po-D9
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 03:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2txZ-00081p-QI
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 03:00:45 -0400
Message-ID: <1507878038.21465.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 13 Oct 2017 09:00:38 +0200
In-Reply-To: <CA+J4q6dO+V32yF11jFD2jAizigYoZS6eECyuDTgRVfe+a_JUJQ@mail.gmail.com>
References: <CA+J4q6dO+V32yF11jFD2jAizigYoZS6eECyuDTgRVfe+a_JUJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU without X11 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hanji unit <hanjiunit@gmail.com>, qemu-discuss@nongnu.org, qemu-devel@nongnu.org

On Thu, 2017-10-12 at 16:25 -0400, hanji unit wrote:
> Hello, is it possible to run (or rebuild modifying build flags) QEMU
> without support for X11 window system integration?

./configure --disable-gtk --disable-sdl --disable-opengl

cheers,
  Gerd
