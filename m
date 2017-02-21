Received: from eggs.gnu.org ([2001:4830:134:3::10]:60112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cgJC2-0005kN-VM
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cgJBz-0005fD-So
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:45:59 -0500
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
	<1487715299-21102-4-git-send-email-kraxel@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <75d73ef2-feae-452a-418f-32c7effc4b37@reactos.org>
Date: Tue, 21 Feb 2017 23:45:10 +0100
MIME-Version: 1.0
In-Reply-To: <1487715299-21102-4-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/9] ppc: use ppc_graphic_* defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, "open list:New World" <qemu-ppc@nongnu.org>

Le 21/02/2017 =E0 23:14, Gerd Hoffmann a =E9crit :
> This switches over ppc to use the new ppc_graphic_* defines.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/ppc/mac_newworld.c |  6 +++---
>  hw/ppc/mac_oldworld.c |  6 +++---
>  hw/ppc/prep.c         | 10 +++++-----
>  hw/ppc/spapr.c        |  6 +++---
>  4 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Herv=E9 Poussineau <hpoussin@reactos.org>
