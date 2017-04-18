Received: from eggs.gnu.org ([2001:4830:134:3::10]:43900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d0T9f-0000mX-Dv
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d0T9e-0003Nd-HF
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:26:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170414083717.13641-1-lvivier@redhat.com>
	<20170414083717.13641-5-lvivier@redhat.com>
Date: Tue, 18 Apr 2017 15:26:45 +0200
In-Reply-To: <20170414083717.13641-5-lvivier@redhat.com> (Laurent Vivier's
	message of "Fri, 14 Apr 2017 10:37:17 +0200")
Message-ID: <87h91l3kyy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/4] qdev: remove
 cannot_destroy_with_object_finalize_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Antony Pavlov <antonynpavlov@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

Laurent Vivier <lvivier@redhat.com> writes:

> As all users have been removed, we can remove
> cannot_destroy_with_object_finalize_yet field
> from the DeviceClass structure.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Huzzah!

Reviewed-by: Markus Armbruster <armbru@redhat.com>
