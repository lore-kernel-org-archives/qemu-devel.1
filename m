Received: from eggs.gnu.org ([2001:4830:134:3::10]:34309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ea1mx-0003qT-If
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ea1mt-0001ay-HW
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:02:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ea1mt-0001Zz-Bn
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:02:35 -0500
Date: Fri, 12 Jan 2018 18:02:32 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180112174621-mutt-send-email-mst@kernel.org>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
	<CAFEAcA_pt7XhXOhL2jSxwH9ooL7xjShmp6eBAYpRLc=dY-=TXQ@mail.gmail.com>
	<20171221223704-mutt-send-email-mst@kernel.org>
	<CAAdtpL74ZyVsLwgBjpbsdSHbWdY_Uq6ouRAvgo00UdVevTKq8A@mail.gmail.com>
	<20171222014258-mutt-send-email-mst@kernel.org>
	<CAFEAcA8eKTEh3zSOPNm1WgUujNOU+zcNSgBAE5G68QcObQd8sA@mail.gmail.com>
	<20180109060920-mutt-send-email-mst@kernel.org>
	<CAFEAcA_Xhm45N5U8aWZv=geVQMShv13FOEodS7HvPTz3fa9-+A@mail.gmail.com>
	<20180111230524-mutt-send-email-mst@kernel.org>
	<CAFEAcA-UvuuJmz-7ppuvnmEz2ZpOBnyfVUoufrsURN4TF9vkTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-UvuuJmz-7ppuvnmEz2ZpOBnyfVUoufrsURN4TF9vkTw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/25] pc, pci, virtio: features, fixes,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philippe@mathieu-daude.net>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jan 12, 2018 at 10:44:39AM +0000, Peter Maydell wrote:
> On 11 January 2018 at 21:05, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Merged and pushed. Pls merge, but please also make sure
> > I didn't modify any submodules by mistake.
> 
> 
> Applied, thanks. Submodule stuff all ok (my apply-pullreq
> script checks these days that there aren't any submodule
> changes in by mistake).
> 
> -- PMM

Good to know. Note to self: don't merge upstream into a branch
in the future. Always checkout upstream, merge branch there.

-- 
MST
