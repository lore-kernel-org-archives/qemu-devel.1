Received: from eggs.gnu.org ([2001:4830:134:3::10]:45281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fPrd0-0004d5-Rl
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fPrd0-0000pV-0N
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:42:38 -0400
References: <20180603000827.30872-1-f4bug@amsat.org>
	<20180603000827.30872-7-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <de26076f-df8e-f202-4f94-d9995618e14b@redhat.com>
Date: Mon, 4 Jun 2018 17:42:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180603000827.30872-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/8] sdcard: Disable SEND_IF_COND (CMD8)
 for Spec v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>

On 03/06/2018 02:08, Philippe Mathieu-Daud=C3=A9 wrote:
> Paolo, I guess this would be a good use of the
> Based-on: 201204252110.20873.paul@codesourcery.com tag in
> the git history :P

Oh, I see you did send it.  Thanks!

"Based-on" means that it applies to a tree with that patch.  It doesn't
mean that's the code you were looking at, when writing the patch.

Thanks,

Paolo
