Received: from eggs.gnu.org ([209.51.188.92]:37834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hFMqI-0000PS-7O
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 13:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hFMqH-0000Og-92
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 13:53:30 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <b30d2279-2311-5b3e-6108-e93577bc7255@redhat.com>
References: <cover.1554992449.git.berto@igalia.com>
	<6c17d784-c5e4-9a3c-c38c-19940352ea35@redhat.com>
	<w51zhoufg2l.fsf@maestria.local.igalia.com>
	<b30d2279-2311-5b3e-6108-e93577bc7255@redhat.com>
Date: Sat, 13 Apr 2019 19:53:25 +0200
Message-ID: <w51zhotu6zu.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] Fix check for default backing
 files in bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Sat 13 Apr 2019 05:48:11 PM CEST, Max Reitz <mreitz@redhat.com> wrote:
>> Ok, you can leave out the second patch then. The first one should
>> still be correct, right?
>
> I just think it=E2=80=99s unnecessary because as of my series both
> backing_file and auto_backing_file serve the purpose.

Ok then!

Berto
