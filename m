Received: from eggs.gnu.org ([2001:4830:134:3::10]:35923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQpdU-0006Qp-1S
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 03:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQpdP-0004h5-3K
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 03:47:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49304 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fQpdO-0004gT-Vd
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 03:47:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180605132915.3640-1-kraxel@redhat.com>
Date: Thu, 07 Jun 2018 09:47:01 +0200
In-Reply-To: <20180605132915.3640-1-kraxel@redhat.com> (Gerd Hoffmann's
	message of "Tue, 5 Jun 2018 15:29:15 +0200")
Message-ID: <87vaav2g3u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] usb: update docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Gerd Hoffmann <kraxel@redhat.com> writes:

> xhci is rock solid meanwhile.  So move it up in the docs and feature it
> as prefered usb host adapter, instead of the old shy version saying "you
> might want try ...".
>
> While being at it rework the text on ehci and companion controllers too.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
