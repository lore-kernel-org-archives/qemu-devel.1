Received: from eggs.gnu.org ([2001:4830:134:3::10]:37815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1caii0-000581-JP
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:47:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1caihv-0007U4-Mv
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:47:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1caihv-0007Tt-HL
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:47:47 -0500
Message-ID: <1486385264.32329.4.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 06 Feb 2017 13:47:44 +0100
In-Reply-To: <1486146260-8092-1-git-send-email-peter.maydell@linaro.org>
References: <1486146260-8092-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] ui/vnc: Drop unused vnc_has_job() and
 vnc_jobs_clear()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

On Fr, 2017-02-03 at 18:24 +0000, Peter Maydell wrote:
> The functions vnc_has_job() and vnc_jobs_clear() are
> never used; remove them.

Added to ui patch queue.

thanks,
  Gerd
