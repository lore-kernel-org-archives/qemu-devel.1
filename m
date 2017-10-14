Received: from eggs.gnu.org ([2001:4830:134:3::10]:33047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e3PSO-00047N-Jb
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 12:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e3PSK-00040r-Mp
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 12:38:36 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CA+J4q6dO+V32yF11jFD2jAizigYoZS6eECyuDTgRVfe+a_JUJQ@mail.gmail.com>
	<1507878038.21465.3.camel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fa3d7fbc-827f-a28b-0cf0-ff0c3f43a0fe@amsat.org>
Date: Sat, 14 Oct 2017 13:38:28 -0300
MIME-Version: 1.0
In-Reply-To: <1507878038.21465.3.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU without X11 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, hanji unit <hanjiunit@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-discuss@nongnu.org, qemu-devel@nongnu.org

>> Hello, is it possible to run (or rebuild modifying build flags) QEMU
>> without support for X11 window system integration?
> 
> ./configure --disable-gtk --disable-sdl --disable-opengl

Is there some interest in adding a simpler --disable-x11 option?
