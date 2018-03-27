Received: from eggs.gnu.org ([2001:4830:134:3::10]:34120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f0f0k-00015f-5a
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f0f0j-0007CW-EA
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:10:58 -0400
Date: Tue, 27 Mar 2018 11:10:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180327031037.GI31422@lemon.usersys.redhat.com>
References: <20180323143202.28879-1-lvivier@redhat.com>
	<20180323143202.28879-5-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323143202.28879-5-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] qdict: remove useless cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, Alberto Garcia <berto@igalia.com>, qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>

On Fri, 03/23 15:32, Laurent Vivier wrote:
> Re-run Coccinelle script scripts/coccinelle/qobject.cocci
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

This time for the right revision of the patch:

Acked-by: Fam Zheng <famz@redhat.com>
