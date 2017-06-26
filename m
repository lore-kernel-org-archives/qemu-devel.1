Received: from eggs.gnu.org ([2001:4830:134:3::10]:58229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPLh2-00007i-9x
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 00:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPLh1-00029c-KF
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 00:32:08 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <e8e3e476-6cc3-30b8-b4b1-cc91704293d6@redhat.com>
References: <20170609150600.4654-1-f4bug@amsat.org>
	<20170609150600.4654-2-f4bug@amsat.org>
	<e8e3e476-6cc3-30b8-b4b1-cc91704293d6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 26 Jun 2017 01:32:06 -0300
Message-ID: <CAAdtpL519bUH1NU4P0yac-HCNCs_kf5Pj8n9UEpx8=+R=zp=KA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] arm/highbank: use defined type
 name instead of hard-coded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

On Fri, Jun 23, 2017 at 7:18 PM, John Snow <jsnow@redhat.com> wrote:
> This patch is fine, I took a stab at fixing the include issues in a
> separate series. Try it all out and let me know.

Thank John, your series does fix my include issues :)
