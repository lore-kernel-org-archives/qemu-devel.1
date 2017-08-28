Received: from eggs.gnu.org ([2001:4830:134:3::10]:58350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmIDM-0007Ex-Pq
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmIDJ-0005Ft-LW
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:28:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
Date: Mon, 28 Aug 2017 13:28:14 +0200
In-Reply-To: <20170728053610.15770-1-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri,
	28 Jul 2017 02:35:23 -0300")
Message-ID: <87mv6k2apd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/47] add missing entries in MAINTAINERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi,
>
> I first prepared this series thinking about 2.10 but then realized if som=
eone
> is calling ./scripts/get_maintainer.pl he better is using an updated git
> clone :)
>
> Distribs do provide docs/ files in /usr/share/doc/qemu* but not the
> MAINTAINERS file so no hurry for this series.
>
> I provided the script I used in the last patch, I plan to improve it so
> patchew/travis can start to use it: if a new file is added to the reposit=
ory
> without being covered in MAINTAINERS the script remember the submitter ab=
out
> it and eventually he'll resend his patch, I think this is a good practice=
 and
> help the next contributors (anyway this is a valuable experience to look =
at a
> file history to see who has been hacking around when there is no MAINTAIN=
ERS
> entry).
>
> I don't want to overburden current maintainers, so the last patches add
> Orphans entries but I tried to select relevant commiters and include them=
 in
> each patch.
>
> The criteria I used is "If I change this file, who should I notify? Who w=
ould
> be interested?"

Where do we stand with this series?
