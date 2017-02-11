Received: from eggs.gnu.org ([2001:4830:134:3::10]:54936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ccMDX-00061N-Gs
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 20:11:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ccMDW-0006TG-HQ
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 20:11:11 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <87r337ako2.fsf@dusky.pond.sub.org>
References: <1486576658-29719-1-git-send-email-thuth@redhat.com>
	<87r337ako2.fsf@dusky.pond.sub.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 10 Feb 2017 17:10:37 -0800
Message-ID: <CAKmqyKPDj2XNsRA+7H4zhL2f4xuG0uZLrFPh5E7WnMAiP0=iCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On Wed, Feb 8, 2017 at 11:27 PM, Markus Armbruster <armbru@redhat.com> wrote:
> Thomas Huth <thuth@redhat.com> writes:
>
>> The "qemu,register" device needs to be wired up in source code, there
>> is no way the user can make any real use of this device with the
>> "-device" parameter or the "device_add" monitor command yet.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

>
