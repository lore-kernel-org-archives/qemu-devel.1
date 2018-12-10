Received: from eggs.gnu.org ([2001:4830:134:3::10]:54819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWMcq-00065u-Us
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWMcl-0005ep-W4
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:33:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gWMcl-0005ea-My
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:33:31 -0500
Date: Mon, 10 Dec 2018 15:33:27 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181210143327.r4j4m7m7jt52f65s@sirius.home.kraxel.org>
References: <1542777026-2788-1-git-send-email-liq3ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542777026-2788-1-git-send-email-liq3ea@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] fw_cfg: fix boot bootsplash and
 reboot-timeout error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: armbru@redhat.com, pbonzini@redhat.com, lersek@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org

On Tue, Nov 20, 2018 at 09:10:23PM -0800, Li Qiang wrote:
> And also do some code cleanup.
> A lot of thanks to Markus's review and advice.
> 
> v2: fix some small issue per Markus's review.
> 
> Li Qiang (3):
>   fw_cfg: fix -boot bootsplash error checking
>   fw_cfg: fix -boot reboot-timeout error checking
>   fw_cfg: make qemu_extra_params_fw locally

Series is
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
