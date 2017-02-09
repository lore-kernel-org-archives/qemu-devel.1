Received: from eggs.gnu.org ([2001:4830:134:3::10]:34252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cbj8c-0002Cc-Br
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 02:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cbj8a-0006qx-Hy
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 02:27:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1486576658-29719-1-git-send-email-thuth@redhat.com>
Date: Thu, 09 Feb 2017 08:27:25 +0100
In-Reply-To: <1486576658-29719-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Wed, 8 Feb 2017 18:57:38 +0100")
Message-ID: <87r337ako2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] hw/core/register: Mark the device with
 cannot_instantiate_with_device_add_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> The "qemu,register" device needs to be wired up in source code, there
> is no way the user can make any real use of this device with the
> "-device" parameter or the "device_add" monitor command yet.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
