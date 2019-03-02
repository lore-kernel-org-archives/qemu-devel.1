Received: from eggs.gnu.org ([209.51.188.92]:46909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h08yj-0001OE-Vc
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 13:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h08lf-0006ma-LN
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 12:49:48 -0500
Date: Sat, 2 Mar 2019 09:49:35 -0800
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190302174935.iocl7vnsm6k3l3jn@function>
References: <1551476756-25749-1-git-send-email-will@wbowling.info>
	<77613668-7b49-0c45-70ed-0684831a5b03@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77613668-7b49-0c45-70ed-0684831a5b03@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: check sscanf result when emulating
 ident
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: William Bowling <will@wbowling.info>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, secalert@redhat.com

Hello,

Philippe Mathieu-Daud=C3=A9, le sam. 02 mars 2019 18:42:42 +0100, a ecrit=
:
> Samuel: since this diff is not obvious without looking at the context
> (also due to the code re-indent),

I dropped the code re-indent to make the change obvious. I still added
the commit description, always better goes with saying it :)

Thanks!

Samuel
