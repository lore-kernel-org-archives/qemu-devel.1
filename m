Received: from eggs.gnu.org ([2001:4830:134:3::10]:59866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dPqYe-00015F-Lb
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dPqYa-0008UK-OD
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:29:32 -0400
References: <20170623164557.11636-1-f4bug@amsat.org>
	<20170623164557.11636-2-f4bug@amsat.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <749af2f9-2475-dd6a-5a45-cccb9428ca7b@msgid.tls.msk.ru>
Date: Tue, 27 Jun 2017 16:29:27 +0300
MIME-Version: 1.0
In-Reply-To: <20170623164557.11636-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] elf-loader: warn about invalid
 endianess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

23.06.2017 19:45, Philippe Mathieu-Daud=C3=A9 wrote:
> fprintf(stderr) is how errors are reported in this file.

Applied to -trivial (with typo fix), thanks!

/mjt
